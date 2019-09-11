# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :sign_in_required
  before_action :set_sheet
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_select1, :toggle_select2, :toggle_select3]


  def index
    @tasks = @sheet.tasks.all
  end

  def show
  end

  def new
    @task = @sheet.tasks.build
  end

  def edit
  end

  def create
    @task = @sheet.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        if @sheet.tasks.size > 14
           @sheet.update!(status: Sheet.statuses[:select_1])
        end

        format.html { redirect_to sheet_path(@task.sheet_id), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @sheet, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def toggle_select1
    session[:mode] = 1
    @task.toggle(:select1)
    respond_to do |format|
      if @task.save
        if @sheet.tasks.where(select1: :true).size == 3
          @sheet.update!(status: Sheet.statuses[:select_2])
        end

        format.html { redirect_to @sheet, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @sheet }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle_select2
    session[:mode] = 2
    @task.toggle(:select2)
    respond_to do |format|
      if @task.save
        if @sheet.tasks.where(select2: :true).size == 3
          @sheet.update!(status: Sheet.statuses[:select_3])
        end

        format.html { redirect_to @sheet, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @sheet }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle_select3
    session[:mode] = 3
    @task.toggle(:select3)
    respond_to do |format|
      if @task.save
        format.html { redirect_to @sheet, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @sheet }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_sheet
      @sheet = Sheet.where(id: params[:sheet_id]).first
    end

    def set_task
      @task = @sheet.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :sheet_id)
    end
end
