require 'rails_helper'

describe 'タスク管理機能', type: :system do
	# ユーザーA・Bを作成(nameとemailは指定した値に変更)
	let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
	let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
	# 作成者がユーザーAであるタスクを作成(nameは指定した値に変更、user_aとの関連を指定。非遅延評価。)
	let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a) }

	before do
		# ログイン処理
		visit login_path
		fill_in 'メールアドレス', with: login_user.email
		fill_in 'パスワード', with: login_user.password
		click_button 'ログインする'
    end

	# it(= example)の共通化(= share)
	shared_examples_for 'ユーザーAが作成したタスクが表示される' do
		# 作成済みのタスクの名前が画面上に表示されていることを確認
		it { expect(page).to have_content '最初のタスク' }
	end

    describe '一覧表示機能' do
        context 'ユーザーAがログインしているとき' do
            # ユーザーAでログイン
			let(:login_user) { user_a }

            it_behaves_like 'ユーザーAが作成したタスクが表示される'
        end

        context 'ユーザーBがログインしているとき' do
            # ユーザーBでログイン
			let(:login_user) { user_b }

			it 'ユーザーAが作成したタスクが表示されない' do
				# ユーザーAが作成したタスクの名称が画面上に表示されていないことを確認
				expect(page).not_to have_content '最初のタスク'
			end
        end
	end

	describe '詳細表示機能' do
		context 'ユーザーAがログインしているとき' do
			# ユーザーAでログイン
			let(:login_user) { user_a }

			before do
				# 詳細画面へ移動
				visit task_path(task_a)
			end

			# タスクが表示される
			it_behaves_like 'ユーザーAが作成したタスクが表示される'
		end
	end

	describe '新規作成機能' do
		let(:login_user) { user_a }

		before do
			visit new_task_path
			# task_nameで場合け
			fill_in '名前', with: task_name
			click_button '登録する'
		end

		context '名称を入力した場合' do
			# task_nameに右辺を代入し、場合分け
			let(:task_name) { '新規作成のテストを書く' }

			it '正常に登録される' do
				expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
			end
		end

		context '名称を入力しない場合' do
			# task_nameに右辺を代入し、場合分け
			let(:task_name) { '' }

			it 'エラーになる' do
				within '#error_explanation' do
					expect(page).to have_content '名前を入力してください'
				end
			end
		end
	end
end
