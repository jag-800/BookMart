# frozen_string_literal: true
# This migration comes from acts_as_taggable_on_engine (originally 2)

class AddMissingUniqueIndices < ActiveRecord::Migration[6.0]
  def self.up
    add_index ActsAsTaggableOn.tags_table, :name, unique: true

    # この行が外部キー制約に必要なインデックスを削除しようとしている可能性があるため、コメントアウトします
    # remove_index ActsAsTaggableOn.taggings_table, :tag_id if index_exists?(ActsAsTaggableOn.taggings_table, :tag_id)
    
    # このインデックスが外部キー制約に関係していない場合のみ、この行を実行します
    remove_index ActsAsTaggableOn.taggings_table, name: 'taggings_taggable_context_idx' if index_exists?(ActsAsTaggableOn.taggings_table, 'taggings_taggable_context_idx')

    add_index ActsAsTaggableOn.taggings_table,
              %i[tag_id taggable_id taggable_type context tagger_id tagger_type],
              unique: true, name: 'taggings_idx'
  end

  def self.down
    remove_index ActsAsTaggableOn.tags_table, :name

    remove_index ActsAsTaggableOn.taggings_table, name: 'taggings_idx'

    # この行も同様に、外部キー制約に関連しているか確認が必要です
    unless index_exists?(ActsAsTaggableOn.taggings_table, [:taggable_id, :taggable_type, :context], name: "taggings_taggable_context_idx")
      add_index ActsAsTaggableOn.taggings_table, [:taggable_id, :taggable_type, :context], name: "taggings_taggable_context_idx"
    end
  end
end

