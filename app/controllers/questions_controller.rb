# frozen_string_literal: true

class QuestionsController < ApplicationController
  include CurrentUserConcern

  def index
    order = params[:sort_order] || :desc
    institution = Institution.find(params[:institution_id]) if params[:institution_id]
    @questions = Question.all.order(created_at: order).map do |q|
      user_vote = nil
      if @current_user
        user_vote = UserAnswerVote.where(user_id: @current_user.id, answer_id: q.correct_answer_id).last
      end

      correct_answer_serialized = nil
      if q.correct_answer
        correct_answer_serialized = q.correct_answer.attributes.merge({ 
          creator: q.correct_answer.creator.as_json, 
          votes: q.correct_answer.votes.as_json, 
          user_vote: user_vote.as_json })
      end

      next if !params[:institution_id].nil? && q.creator.institution_id != institution.id

      q.attributes.merge({ creator: q.creator, votes: q.votes,
        category: q.category.as_json,
        correct_answer: correct_answer_serialized })
    end

    render json: @questions.reject {|e| !e.present?}.as_json,
           status: :ok
  end

  def show
    @question = Question.find_by(id: params[:id])

    if @question
      user_vars = {
        vote: nil,
        is_saved: false
      }
      if @current_user
        user_vars = {
          vote: UserQuestionVote.where(user_id: @current_user.id, question_id: @question.id).last,
          is_saved: UserSavedQuestion.where(user_id: @current_user.id, question_id: @question.id).last.present?
        }
      end

      user_vote = nil
      if @current_user
        user_vote = UserAnswerVote.where(user_id: @current_user.id, answer_id: @question.correct_answer_id).last
      end

      correct_answer_serialized = nil
      if @question.correct_answer
        correct_answer_serialized = @question.correct_answer.attributes.merge({ 
          creator: @question.correct_answer.creator.as_json, 
          votes: @question.correct_answer.votes.as_json, 
          user_vote: user_vote.as_json })
      end

      render json: { question: @question.as_json
                                        .merge(creator: @question.creator
                                        .as_json, votes: @question.votes.as_json, user_vars: user_vars,
                                               category: @question.category.as_json,
                                               correct_answer: correct_answer_serialized ) },
             status: :ok
    else
      not_found
    end
  end

  def create
    if @current_user
      @question = Question.new(question_params.merge(user_id: @current_user.id))

      if @question.save
        category = QuestionCategory.where(title: params[:question][:category]).last
        if category
          CategoryToQuestion.create!(question_category_id: category.id, question_id: @question.id)
        end

        render json: { question: @question.as_json, category: @question.category.as_json },
               status: :created
      else
        render json: { errors: @question.errors.full_messages },
               status: :unprocessable_entity
      end
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def vote_question
    if @current_user
      question = Question.find params[:question_id]

      # If there already exists a saved record, delete it
      @user_question_vote = UserQuestionVote.where(user_id: @current_user.id, question_id: params[:question_id]).last

      if @user_question_vote.present?
        @user_question_vote.destroy

        render json: { votes: question.votes },
               status: :ok
      else
        @user_question_vote = UserQuestionVote.new(user: @current_user, question: question, negative: params[:negative])
        if @user_question_vote.save
          render json: { votes: question.votes },
                 status: :created
        else
          render json: { errors: @user_question_vote.errors.full_messages },
                 status: :unprocessable_entity
        end
      end
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def save_question
    if @current_user
      question = Question.find params[:question_id]

      # If there already exists a saved record, delete it
      @user_saved_question = UserSavedQuestion.where(user_id: @current_user.id, question_id: params[:question_id]).last

      if @user_saved_question.present?
        @user_saved_question.destroy

        render json: { hasUnsaved: true },
               status: :ok
      else
        @user_saved_question = UserSavedQuestion.new(user: @current_user, question: question)

        if @user_saved_question.save
          render json: { user_saved_question: @user_saved_question },
                 status: :created
        else
          render json: { errors: @user_saved_question.errors.full_messages },
                 status: :unprocessable_entity
        end
      end
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def search_question
    q = params[:q]
    @questions = Question.where('title ILIKE ?', "%#{q}%")
    render json: { questions: @questions.as_json },
           status: :ok
  end

  def mark_correct_answer
    if @current_user
      question = Question.find params[:question_id]

      # Unmark correct answer case
      if question.correct_answer_id == params[:correct_answer_id]
        question.update!(correct_answer_id: nil)
        render json: { correct_answer: nil, unmarked: true },
               status: :created
      else

        question.update!(correct_answer_id: params[:correct_answer_id])

        user_vote = UserAnswerVote.where(user_id: @current_user.id, answer_id: question.correct_answer_id).last

        if question.correct_answer
          render json: { correct_answer: question.correct_answer.attributes.merge({ 
            creator: question.correct_answer.creator.as_json, votes: question.correct_answer.votes.as_json, user_vote: user_vote.as_json })
          },
                status: :created
        else
          render json: { errors: 'unprocessable_entity' },
                status: :unprocessable_entity
        end
      end
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :description)
  end
end
