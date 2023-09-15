require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do
    describe 'ユーザー登録機能' do
        context '入力情報に誤りがある場合' do
            it "登録失敗" do 
                visit signup_path
                user_attributes = FactoryBot.attributes_for(:user) 
                submit_and_count_errors

                fill_in name: "user[username]", with: user_attributes[:username]
                submit_and_count_errors
                
                fill_in name: "user[email]", with: user_attributes[:email]
                submit_and_count_errors
                
                fill_in name: "user[password]", with: user_attributes[:password]
                submit_and_count_errors 

                fill_in name: "user[password_confirmation]", with: user_attributes[:password_confirmation] 
                submit_and_count_errors 
            end 
        end 
        def submit_and_count_errors 
            click_button "新規登録" 
            within ".alert.alert-danger" do
                expect(page.all('li').count).to_not eq 0
            end
        end 
    end
end