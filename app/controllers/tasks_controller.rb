class TasksController < ApplicationController
  # フィルターを使って重複を避ける(Dont Repeat Yourself)
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # @tasks = Task.all  リレーション適用前
    # @tasks = current_user.tasks.recent  Ransack適用前
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true)
  end

  def show
    # @task = Task.find(params[:id])  リレーション適用前
  end

  def new
    @task = Task.new
  end

  def create
    # @task = Task.new(task_params)  <- リレーション前のコード
    # ログイン中のユーザーに紐づいたタスクを作る(current_userはapplication_controllerにある)
    @task = current_user.tasks.new(task_params)

    # 確認画面で'戻る'が押されたとき
    if params[:back].present?
      render :new
      return
    end

    if @task.save
      redirect_to tasks_path, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    @task.destroy!
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"
  end

  # 確認画面
  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  private

  # strong parameters(create, updateで利用する)
  def task_params
    params.require(:task).permit(:name, :description)
  end

  # フィルターを使って重複を避ける(Dont Repeat Yourself)
  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
