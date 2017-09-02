class FeedbacksController < ApplicationController
	def index
		@feedbacks = Feedback.all
  end

  def new
    @feedback = Feedback.new
  end

  def create
  	@feedback = Feedback.new(feedback_params)
    if @feedback.save
      flash[:success] = "Thanks for your feedback"
      redirect_to feedbacks_path
    else
      flash[:danger] = "Your feedback is not submitted successfully, please fulfill all the fields"
      redirect_to feedbacks_path
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit!
  end
end
