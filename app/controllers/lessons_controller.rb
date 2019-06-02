class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson

  def show
  end

  private

  helper_method :current_lesson
  helper_method :current_course
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
  
  def current_course
    @current_course = current_lesson.section.course
  end

  def require_authorized_for_current_lesson
    if !current_user.enrolled_in?(current_course)
      redirect_to course_path(current_course), alert: 'Only enrolled students may view lessons.'
    end
  end
end
