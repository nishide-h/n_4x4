# frozen_string_literal: true

class SheetsController < ApplicationController
  before_action :sign_in_required
  before_action :set_sheet, only: [:show, :edit, :update, :next_status, :prev_status, :destroy]

  def index
    @sheets = current_user.sheets.order(created_at: "DESC").page(params[:page])
  end

  def show
    @tasks = @sheet.tasks.order(:created_at)
  end

  def new
    @sheet = Sheet.new
  end

  def edit
  end

  def create
    @sheet = current_user.sheets.new(sheet_params)

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

  def next_status
    @sheet.status = @sheet.status_before_type_cast + 1
    respond_to do |format|
      if @sheet.save
        format.html { redirect_to @sheet, notice: "Sheet was successfully updated." }
        format.json { render :show, status: :ok, location: @sheet }
      else
        format.html { render :show }
        format.json { render json: @sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  def prev_status
    @sheet.status = @sheet.status_before_type_cast - 1
    respond_to do |format|
      if @sheet.save
        format.html { redirect_to @sheet, notice: "Sheet was successfully updated." }
        format.json { render :show, status: :ok, location: @sheet }
      else
        format.html { render :show }
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
      @sheet = current_user.sheets.find(params[:id])
    end

    def sheet_params
      params.require(:sheet).permit(:title)
    end
end

