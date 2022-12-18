class TasksController < ApplicationController
  # フィルターを使って重複を避ける(Dont Repeat Yourself)
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # @tasks = Task.all  リレーション適用前
    # @tasks = current_user.tasks.recent  Ransack適用前
    # Ransakによる検索機能(:q の値が空だった場合は全件取得と同じ挙動をする)
    @q = current_user.tasks.ransack(params[:q])
    # kaminariによるページネーション("/tasks?page=2"のような形式ではなく、"/tasks"だけの場合はpage=1の場合と同じ挙動)
    @tasks = @q.result(distinct: true).page(params[:page])

    # CSVの出力
    respond_to do |format|
      format.html
      format.csv { send_data @tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
    end
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
      # メール
      TaskMailer.creation_email(@task).deliver_now
      # 非同期処理
      SampleJob.perform_later

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
    @task.destroy
    # レスポンスのボディはなしで、HTTPステータスとして204が返る
    # head :no_content
  end


  # 確認画面
  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  # CSVの入力
  def import
    current_user.tasks.import(params[:file])
    redirect_to tasks_url, notice: "タスクを追加しました"
  end

  private

  # strong parameters(create, updateで利用する)
  def task_params
    params.require(:task).permit(:name, :description, :image)
  end

  # フィルターを使って重複を避ける(Dont Repeat Yourself)
  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
