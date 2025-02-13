FactoryBot.define do
  factory :store do
    name { "Loja Exemplo" }
    owner { "Dono Exemplo" }
  end
end

# == Schema Information
#
# Table name: stores
#
#  id         :bigint           not null, primary key
#  name       :string
#  owner      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_stores_on_name_and_owner  (name,owner) UNIQUE
#
