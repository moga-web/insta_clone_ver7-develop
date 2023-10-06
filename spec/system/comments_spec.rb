require 'rails_helper'

RSpec.describe 'Comments', type: :system do
    let!(:user) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:post) { create(:post, user: user) }
    
    describe 'コメント投稿機能' do
        before do
            login_as(user)
        end
        it 'コメントが投稿できること' do
            visit post_path(post)
            within '#form_comment' do
                fill_in 'コメント', with: 'テストコメント'
                click_button '登録する'
            end
            expect(page).to have_content 'テストコメント'
        end
    end

    describe 'コメント編集機能' do
        let! (:comment) { create(:comment, post: post, user: user2) }
        context '自分のコメントの場合' do
            before do
                login_as(user2)
            end
            it 'コメントが編集できること' do
                visit post_path(post)
                within "#comment_#{comment.id}" do
                    find('.btn-edit').click
                end
                within "#form_comment_#{comment.id}" do
                    fill_in 'コメント', with: '更新コメントです'
                    click_on '更新する'
                end
                expect(page).to have_content '更新コメント'
            end
        end
        context '他人のコメントの場合' do
            before do
                login_as(user)
            end
            it '編集ボタンが表示されないこと' do
                visit post_path(post)
                within "#comment_#{comment.id}" do
                    expect(page).not_to have_button '.btn-edit'
                end
            end
        end
    end

    describe 'コメント削除機能' do
        let! (:comment) { create(:comment, post: post, user: user2)  }
        context '自分のコメントの場合' do
            before do
                login_as(user2)
            end
            it 'コメントが削除できること' do
                visit post_path(post)
                within "#comment_#{comment.id}" do
                    accept_confirm{find('.btn-delete').click}
                end
                expect(page).not_to have_content comment.body
            end
        end
        context '他人のコメントの場合' do
            before do
                login_as(user)
            end
            it '削除ボタンが表示されないこと' do
                visit post_path(post)
                within "#comment_#{comment.id}" do
                    expect(page).not_to have_button '.btn-delete'
                end
            end
        end
    end
end