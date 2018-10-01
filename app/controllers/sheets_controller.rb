class SheetsController < ApplicationController
  before_action :set_sheet, only: [:show, :edit, :update, :destroy]

  def index
    @sheets = Sheet.all
  end

  def show
  end

  def new
    @sheet = Sheet.new
  end

  # GET /sheets/1/edit
  def edit
  end

  def create
    @sheet = Sheet.new(sheet_params)

    respond_to do |format|
      if @sheet.save
        format.html { redirect_to @sheet, notice: 'Sheet was successfully created.' }
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
        format.html { redirect_to @sheet, notice: 'Sheet was successfully updated.' }
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
      format.html { redirect_to sheets_url, notice: 'Sheet was successfully destroyed.' }
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
