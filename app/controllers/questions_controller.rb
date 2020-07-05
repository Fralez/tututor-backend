class QuestionsController < ApplicationController
  before_action :authorize_request, except: %i[index show search_question]

  def index
    @questions = Question.all.map { |q| q.attributes.merge({ creator: q.creator }) }

    render json: @questions.as_json,
           status: :ok
  end

  def show
    @question = Question.find_by(id: params[:id])

    @current_user = get_current_user

    user_vars = nil
    if @current_user.present?
      user_vars = {
        has_voted: UserQuestionVote.where(user_id: @current_user.id, question_id: @question.id).last.present?,
        has_saved_question: UserSavedQuestion.where(user_id: @current_user.id, question_id: @question.id).last.present?
      }
    end

    if @question
      render json: { question: @question.as_json
                                        .merge(creator: @question.creator
                                        .as_json, votes: @question.votes.as_json, user_vars: user_vars ) },
             status: :ok
    else
      not_found
    end
  end

  def create
    @question = Question.new(question_params.merge(user_id: @current_user.id))

    if @question.save
      render json: { question: @question.as_json },
             status: :created
    else
      render json: { errors: @question.errors.full_messages },
             status: :unprocessable_entity
    end
  end


  def vote_question
    user = User.find params[:user_id]
    question = Question.find params[:question_id]

    # If there already exists a saved record, delete it
    @user_question_vote = UserQuestionVote.where(user_id: params[:user_id], question_id: params[:question_id]).last

    if @user_question_vote.present?
      @user_question_vote.destroy

      render json: { votes: question.votes },
               status: :ok
    else
      @user_question_vote = UserQuestionVote.new(user: user, question: question, negative: params[:negative])

      if @user_question_vote.save
        render json: { votes: question.votes },
               status: :created
      else
        render json: { errors: @user_question_vote.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  end

  def save_question
    user = User.find params[:user_id]
    question = Question.find params[:question_id]

    # If there already exists a saved record, delete it
    @user_saved_question = UserSavedQuestion.where(user_id: params[:user_id], question_id: params[:question_id]).last

    if @user_saved_question.present?
      @user_saved_question.destroy

      render json: { hasUnsaved: true }, 
             status: :ok
    else
      @user_saved_question = UserSavedQuestion.new(user: user, question: question)

      if @user_saved_question.save
        render json: { user_saved_question: @user_saved_question },
               status: :created
      else
        render json: { errors: @user_saved_question.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  end

  def search_question
    q = params[:q]
    @questions = Question.where('title ILIKE ?', "%#{q}%")
    render json: { questions: @questions.as_json },
           status: :ok
  end

  private

  def question_params
    params.require(:question).permit(:title, :description)
  end
end
