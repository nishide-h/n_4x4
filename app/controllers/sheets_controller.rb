# frozen_string_literal: true

class SheetsController < ApplicationController
  before_action :sign_in_required
  before_action :set_sheet, only: [:show, :edit, :update, :next_status, :prev_status, :destroy]

  def index
    flash[:notice] = "おはようございます！シートを作成して作業を整理しましょう！！"
    @sheets = current_user.sheets.order(updated_at: "DESC")
  end

  def show
    @tasks = @sheet.tasks.order(:created_at)

    if @tasks.size < 15
      @active_mode = 0
      case @tasks.size
      when 1
        flash[:notice] = "3分以内に全て埋めてしまいましょう！"
      when 10
        flash[:notice] = "残り５つ！！"
      else
        flash[:notice] = "次々空欄を埋めて行きましょう！！優先順位を決めるのは全て埋めてから。"
      end
    else
      if @tasks.where(select1: true).size < 3
        if @tasks.where(select1: true).size == 2
          flash[:notice] = "残りひとつです！！"
        else
          flash[:notice] = "書き上げたタスクを俯瞰して、特に重要なものを３つ選択して下さい。"
        end
        @active_mode = 1
      elsif @tasks.where(select2: true).size < 3
        if @tasks.where(select2: true).size == 2
          flash[:notice] = "残りひとつです！！"
        else
          flash[:notice] = "再び全体を見渡して、緊急性の高いものを３つ選択して下さい。重要と被ってもOK"
        end
        @active_mode = 2
      else
        flash[:notice] = "もう一度見渡して、人に頼めるものや今日する必要のないタスクを選択して下さい。個数制限なし選択が終われば完成ボタンを押して下さい。"
        @active_mode = 3
      end
    end
  end

  def new
    flash[:notice] = "シート名称は「今日やることは？」や「本日タスク」はいかがでしょう？"
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
