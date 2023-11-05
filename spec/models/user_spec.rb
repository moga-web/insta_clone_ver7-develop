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

  describe '#follow' do
    let!(:user_a) { create(:user) }
    let!(:user_b) { create(:user) }
    it 'フォローするとRelationshipが増える' do
      expect { user_a.follow(user_b) }.to change { Users::Relationship.count }.by(1)
    end
  end

  describe '#unfollow' do
    let!(:user_a) { create(:user) }
    let!(:user_b) { create(:user) }
    before do
      user_a.follow(user_b)
    end
    it 'フォローを外すとRelationshipが減る' do
      expect { user_a.unfollow(user_b) }.to change { Users::Relationship.count }.by(-1)
    end
  end

  describe '#following' do
    let!(:user_a) { create(:user) }
    let!(:user_b) { create(:user) }
    context 'フォローしている場合' do
      before do
        user_a.follow(user_b)
      end
      it 'trueを返す' do
        expect(user_a.following?(user_b)).to be true
      end
    end

    context 'フォローしいない場合' do
      it 'falseを返す' do
        expect(user_a.following?(user_b)).to be false
      end
    end
  end

  describe '#recent' do
    let(:base_datetime) { Time.current }
    let!(:user_a) { create(:user, created_at: base_datetime) }
    let!(:user_b) { create(:user, created_at: base_datetime.ago(1.second) ) }
    let!(:user_c) { create(:user, created_at: base_datetime.ago(2.second) ) }
    let!(:user_d) { create(:user, created_at: base_datetime.ago(3.second) ) }
    it '新しくアカウントが作られた順にユーザーを取得できる' do
      expect(User.recent(3)).to eq [user_a, user_b, user_c]
    end
  end

  describe '#feed' do
    let!(:user_a) { create(:user) }
    let!(:user_b) { create(:user) }
    let!(:user_c) { create(:user) }
    let!(:post_by_user_a) { create(:post, user: user_a) }
    let!(:post_by_user_b) { create(:post, user: user_b) }
    let!(:post_by_user_c) { create(:post, user: user_c) }
    before do
      user_a.follow(user_b)
    end
    subject { user_a.feed }

    context '自分の投稿と自分がフォローしている人の投稿のみが返される' do
      it '自分の投稿が含まれる' do
        is_expected.to include post_by_user_a
      end

      it 'フォローしている人の投稿が含まれる' do
        is_expected.to include post_by_user_b
      end
      
      it 'フォローしていない人の投稿は含まれない' do
        is_expected.not_to include post_by_user_c
      end
    end
  end
end
