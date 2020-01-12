class GoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :show, :destroy]
  before_action :set_goal,     only: [:show, :edit, :update, :destroy]

  def index
    @goals = current_user.goals.all
  end

  def show
  end

  def new
    @goal = Goal.new
    @trolls = Troll.all.map { |t| [t.name, t.twitter_id] }
  end

  def edit
    @trolls = Troll.all.map { |t| [t.name, t.twitter_id] }
  end

  def create
    @goal = current_user.goals.build(goal_params)
    @trolls = Troll.all.map { |t| [t.name, t.twitter_id] }

    respond_to do |format|
      if @goal.save
        format.html { redirect_to @goal, notice: 'Goal was successfully created.' }
        format.json { render :show, status: :created, location: @goal }
      else
        format.html { render :new }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @trolls = Troll.all.map { |t| [t.name, t.twitter_id] }
    
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to @goal, notice: 'Goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @goal }
      else
        format.html { render :edit }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @goal.destroy
    respond_to do |format|
      format.html { redirect_to goals_url, notice: 'Goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_goal
      @goal = Goal.find(params[:id])
    end

    def goal_params
      params.require(:goal).permit(:name, :query, :mapping, :trigger_calculation, :trigger_type, :trigger_value, :troll_twitter_id)
    end
end
