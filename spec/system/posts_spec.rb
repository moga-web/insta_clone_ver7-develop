require 'rails_helper'

RSpec.describe "Posts", type: :system do
    let!(:user) { create(:user) }
    describe '新規投稿' do
        before do
            login_as(user)
        end
        it '投稿一覧画面に投稿した内容が確認できる' do
            within '#header' do
                click_on '投稿'
            end
            fill_in '本文', with: '新規投稿テスト'
            attach_file '画像', "#{Rails.root}/spec/fixtures/dummy.jpeg"
            click_on '登録する'
            expect(page).to have_content '新規投稿テスト'
        end
    end

    describe '投稿編集' do
        before do
            login_as(user)
        end
        let!(:post) { create(:post, user: user) }
        it '投稿一覧画面で編集後の内容が確認できる' do
            visit "/posts/#{post.id}"
            find('#postDropdownMenuLink').click
            click_on '編集'
            fill_in '本文', with: '編集テスト'
            attach_file '画像', "#{Rails.root}/spec/fixtures/dummy.jpeg"
            click_on '更新する'
            expect(page).to have_content '投稿を更新しました'
            visit root_path
            expect(page).to have_content '編集テスト'
        end
    end

    describe '投稿削除' do
        before do
            login_as(user)
        end
        let!(:post) { create(:post, user: user) }
        it '投稿一覧に削除した投稿が見つからない' do
            visit "/posts/#{post.id}"
            find('#postDropdownMenuLink').click
            click_on '削除'
            page.driver.browser.switch_to.alert.accept 
            expect(page).to have_content '投稿を削除しました'
        end
    end
end