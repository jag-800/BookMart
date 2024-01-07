# frozen_string_literal: true
# This migration comes from acts_as_taggable_on_engine (originally 4)

class AddMissingTaggableIndex < ActiveRecord::Migration[6.0]
  def self.up
    unless index_exists?(ActsAsTaggableOn.taggings_table, [:taggable_id, :taggable_type, :context], name: 'taggings_taggable_context_idx')
      add_index ActsAsTaggableOn.taggings_table, [:taggable_id, :taggable_type, :context],
                name: 'taggings_taggable_context_idx'
    end
  end

  def self.down
    if index_exists?(ActsAsTaggableOn.taggings_table, name: 'taggings_taggable_context_idx')
      remove_index ActsAsTaggableOn.taggings_table, name: 'taggings_taggable_context_idx'
    end
  end
end

