# frozen_string_literal: true

class Dns < ApplicationRecord
  validates :ip, presence: true
  validates :domains, presence: true

  def self.search(include, exclude)
    includes(include)
      .excludes(exclude)
  end

  def self.only_essential_fields
    select(:id, :ip, :domains)
  end

  def self.includes(include)
    return self if include.blank?

    where(domains_contain, include)
  end

  def self.excludes(exclude)
    return self if exclude.blank?

    where.not(domains_contain, exclude)
  end

  def self.domains_contain
    'domains @> ARRAY[?]::varchar[]'
  end
end
