require 'rails_helper'

RSpec.describe 'accounts', type: :system do
    let!(:user) { create(:user) }
    before do
        login_as(user)
    end
    
    describe 'アカウント更新' do
        it 'アカウント更新ができる' do
            find('#navbarDropdownMenuAvatar').click
            click_on 'プロフィール'
            expect(current_path).to eq '/mypage/account/edit'
            
            attach_file 'user[avatar]', "#{Rails.root}/spec/fixtures/dummy.jpeg"
            fill_in 'メールアドレス', with: 'accounts_spec@example.com'
            fill_in 'ユーザー名', with: 'accounts_spec'
            click_on '更新する'
            sleep 1
            expect(page).to have_content 'プロフィールを更新しました'

            user.reload
            expect(user.email).to eq 'accounts_spec@example.com'
            expect(user.username).to eq 'accounts_spec'
            expect(user.avatar).to be_attached
        end
    end
end