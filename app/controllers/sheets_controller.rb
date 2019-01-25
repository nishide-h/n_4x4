# frozen_string_literal: true

class SheetsController < ApplicationController
  before_action :set_sheet, only: [:show, :edit, :update, :destroy]


  MODE = ["登録＞", "選択-重要＞", "選択-緊急＞", "選択-別日/依頼"]

  def index
    @sheets = Sheet.all
  end

  def show
    @mode = MODE
    @tasks = @sheet.tasks

    if @tasks.size < 15
      @active_mode = 0
    else
      if @tasks.where(select1: true).size < 3
        @active_mode = 1
      else
        if @tasks.where(select2: true).size < 3
          @active_mode = 2
        else
          @active_mode = 3
        end
      end
    end
  end

  def new
    @sheet = Sheet.new
  end

  def edit
  end

  def create
    @sheet = Sheet.new(sheet_params)

    respond_to do |format|
      if @sheet.save
        format.html { redirect_to @sheet, notice: "Sheet was successfully created." }
        format.json { render :show, status: :created, location: @sheet }
      else
        format.html { render :new }
        format.json { render json: @sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @sheet.update(sheet_params)
        format.html { redirect_to @sheet, notice: "Sheet was successfully updated." }
        format.json { render :show, status: :ok, location: @sheet }
      else
        format.html { render :edit }
        format.json { render json: @sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sheet.destroy
    respond_to do |format|
      format.html { redirect_to sheets_url, notice: "Sheet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_sheet
      @sheet = Sheet.find(params[:id])
    end

    def sheet_params
      params.require(:sheet).permit(:title)
    end
end
