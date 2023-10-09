require 'rails_helper'

RSpec.describe 'いいね機能', type: :system do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    before do
        login_as(user)
    end
    describe 'いいねといいね解除' do
        it 'いいねといいね解除ができること' do
            visit '/posts'
            #いいねするとハートに色がつく(unlikeボタンが表示される)
            within "#like_post_#{post.id}" do
                find('.btn-like').click
            end
            sleep 0.1
            expect(page).to have_css '.btn-unlike'

            #いいねを解除するとハートの色が消える(likeボタンが表示される)
            within "#like_post_#{post.id}" do
                find('.btn-unlike').click
            end
            sleep 0.1
            expect(page).to have_css '.btn-like'
        end
    end
end