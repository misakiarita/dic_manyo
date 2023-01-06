class TasksController < ApplicationController
  def index
    if params[:sort_expired]
      @tasks = Task.all.order(due: :desc)
    elsif params[:task].present?
      @tasks = Task.where('title LIKE ?', "%#{params[:task][:title]}%")
    else
      @tasks = Task.all.order(created_at: :desc) 
    end
    
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = 'タスク作成しました！'
      redirect_to tasks_path
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = '編集しました！'
      redirect_to tasks_path
    else 
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      flash[:notice] = '削除しました！'
      redirect_to tasks_path
    end
  end

  private

  def task_params
    params.require(:task).permit(:content, :title, :due, :status)
  end

end
