# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string(255)
#  email            :string(255)      not null
#  salt             :string(255)
#  username         :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#like' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }
    it 'いいねができる' do
      expect { user.like(post) }.to change { Like.count }.by(1)
    end
  end

  describe '#unlike' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }
    before do
      user.like(post)
    end
    it 'いいねが解除できる' do
      expect { user.unlike(post) }.to change { Like.count }.by(-1)
    end
  end

  describe '#like?' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }
    let!(:not_like_post) { create(:post) }
    before do 
      user.like(post)
    end
    
    it 'いいねしている場合はtrueを返す' do
      expect(user.like?(post)).to be true
    end

    it 'いいねしていない場合はfalseを返す' do
      expect(user.like?(not_like_post)).to be false
    end
  end

end
