require 'rails_helper'

RSpec.describe 'コメント', type: :system do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    before do
        login_as(user)
    end

    describe 'コメント投稿機能' do
        it 'コメントが投稿できること' do
            visit post_path(post)
            within '#form-comment' do
                fill_in 'コメント', with: 'テストコメント'
                click_button '登録する'
            end
            expect(page).to have_content 'テストコメント'
        end
    end

    describe 'コメント編集機能' do
        let (:comment) { create(:comment, user: user, post: post) }
        it 'コメントが編集できること' do
            visit post_path(post)
            within "#comment-#{comment.id}" do
                find('.comment-edit').click
            end
            within "#form-comment-#{comment.id}" do
                fill_in 'コメント', with: '更新コメント'
                click_on '更新する'
            end
            expect(page).to have_content '更新コメント'
        end
    end

    describe 'コメント削除機能' do
        let (:comment) { create(:comment, user: user, post: post) }
        it 'コメントが削除できること' do
            visit post_path(post)
            within "#comment-#{comment.id}" do
                accept_confirm{find('.comment-delete').click}
            end
            expect(page).not_to have_content comment.body
        end
    end
end