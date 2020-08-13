class AnswersController < ApplicationController
  include CurrentUserConcern

  def index
    @answers = Answer.where(question_id: params[:question_id]).order(created_at: :desc).map do |a|
      user_vote = nil
      if @current_user
        user_vote = UserAnswerVote.where(user_id: @current_user.id, answer_id: a.id).last
      end

      a.attributes.merge({ 
        creator: a.creator.as_json, votes: a.votes.as_json, user_vote: user_vote.as_json
      })
    end

    render json: @answers.as_json,
           status: :ok
  end

  def show
    @answer = Answer.find_by(id: params[:id])

    if @answer
      user_vote = nil
      if @current_user
        user_vote = UserAnswerVote.where(user_id: @current_user.id, answer_id: @answer.id).last
      end

      render json: { answer: @answer.as_json
                                        .merge(creator: @answer.creator
                                        .as_json, votes: @answer.votes.as_json, user_vote: user_vote ) },
             status: :ok
    else
      not_found
    end
  end

  def create
    if @current_user
      @answer = Answer.new(answer_params.merge(user_id: @current_user.id))

      if @answer.save
        render json: { answer: @answer.as_json },
              status: :created
      else
        render json: { errors: @answer.errors.full_messages },
              status: :unprocessable_entity
      end
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def vote_answer
    if @current_user
      answer = Answer.find params[:answer_id]

      # If there already exists a saved record, delete it
      @user_answer_vote = UserAnswerVote.where(user_id: @current_user.id, answer_id: params[:answer_id]).last

      if @user_answer_vote.present?
        @user_answer_vote.destroy

        render json: { votes: answer.votes },
                 status: :ok
      else
        @user_answer_vote = UserAnswerVote.new(user: @current_user, answer: answer, negative: params[:negative])
        if @user_answer_vote.save
          render json: { votes: answer.votes },
                 status: :created
        else
          render json: { errors: @user_answer_vote.errors.full_messages },
                 status: :unprocessable_entity
        end
      end
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:description, :question_id)
  end
end