class KidQuotesController < ApplicationController
  before_action :set_kid_quote, only: [:show, :edit, :update, :destroy]
  
  load_and_authorize_resource :except => :random_quote
  helper_method :sort_column, :sort_direction 

  # GET /kid_quotes
  # GET /kid_quotes.json
  def index
    @kid_quotes = KidQuote.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(10)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @kid_quotes }
      format.js # index.js.erb 
    end
  end

  # GET /kid_quotes/1
  # GET /kid_quotes/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @kid_quote }
    end
  end

  # GET /kid_quotes/new
  # GET /kid_quotes/new.json
  def new
    @kid_quote = KidQuote.new
  end

  # GET /kid_quotes/1/edit
  def edit
  end

  # POST /kid_quotes
  # POST /kid_quotes.json
  def create
    @kid_quote = KidQuote.new(kid_quote_params)
    respond_to do |format|
      if @kid_quote.save
        format.html { redirect_to kid_quotes_path, notice: 'Kid quote was successfully created.' }
        format.json { render json: @kid_quote, status: :created, location: @kid_quote }
      else
        format.html { render action: "new" }
        format.json { render json: @kid_quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /kid_quotes/1
  # PUT /kid_quotes/1.json
  def update
    respond_to do |format|
      if @kid_quote.update(kid_quote_params)
        format.html { redirect_to kid_quotes_path, notice: 'Kid quote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @kid_quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kid_quotes/1
  # DELETE /kid_quotes/1.json
  def destroy
    @kid_quote.destroy

    respond_to do |format|
      format.html { redirect_to kid_quotes_url }
      format.json { head :no_content }
    end
  end

  def random_quote
    @kid_quote = KidQuote.find(:all).sample(n=3)
    render :layout => "random_quote"
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_kid_quote
    @kid_quote = KidQuote.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def kid_quote_params
    params.require(:kid_quote).permit(:quote, :name, :age)
  end
    
  def sort_column
    KidQuote.column_names.include?(params[:sort]) ? params[:sort] : "age"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end