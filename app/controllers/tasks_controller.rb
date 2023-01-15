class TasksController < ApplicationController
  def index
    if params[:sort_expired]
      @tasks = current_user.tasks.all.includes(:user).order(due: :desc).page(params[:page]).per(5)

      # @tasks = Task.all.order(due: :desc).page(params[:page]).per(5)
    elsif params[:priority_level]
      @tasks = current_user.tasks.all.includes(:user).order(priority_level: :asc).page(params[:page]).per(5)
      # @tasks = Task.all.order(priority_level: :asc).page(params[:page]).per(5)
    else
      @tasks = current_user.tasks.all.includes(:user).order(created_at: :desc).page(params[:page]).per(5)

      # @tasks = Task.all.order(created_at: :desc).page(params[:page]).per(5)
    end

    if params[:task].present?
      if params[:task][:status].present? && params[:task][:title].present? 
        @tasks = current_user.tasks.title_search(params[:task][:title]).page(params[:page]).per(5)
        @tasks = current_user.tasks.status_search(params[:task][:status]).page(params[:page]).per(5)
        # @tasks = Task.title_search(params[:task][:title]).page(params[:page]).per(5)
        # @tasks = Task.status_search(params[:task][:status]).page(params[:page]).per(5)  
      elsif params[:task][:title].present?
        @tasks = current_user.tasks.title_search(params[:task][:title]).page(params[:page]).per(5)
        # @tasks = Task.title_search(params[:task][:title]).page(params[:page]).per(5)
      elsif params[:task][:status].present? 
        @tasks = current_user.tasks.status_search(params[:task][:status]).page(params[:page]).per(5)

        # @tasks = Task.status_search(params[:task][:status]).page(params[:page]).per(5)
      end
    end   
  end

  def new
    @task = Task.new
  end


  def create
    @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:content, :title, :due, :status, :priority_level)
  end

end
