# coding: utf-8
class TeacherController < ApplicationController
  def show
    @teacher = Teacher.find(params[:id])
  end

  def index
    @teacher_groups = @school.teacher_group.reverse
  end
end
