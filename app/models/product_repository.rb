class ProductRepository < SimpleDelegator
  DEFAULT_LIMIT = 5
  DEFAULT_OFFSET = 0

  def initialize(repository = Spree::Product)
    __setobj__ repository
  end

  def filter; self; end

  def order; self; end

  def paginate(limit, offset)
    limit ||= DEFAULT_LIMIT
    offset ||= DEFAULT_OFFSET

    __setobj__(__getobj__.limit(limit).offset(offset))

    self
  end

  def to_csv
    CSV.generate do |csv|
      csv << %w(name description price availability_date slug stock_total category)

      __getobj__.each do |pr|
        csv << [
          pr.name,
          pr.description,
          pr.price.to_f,
          pr.available_on,
          pr.slug,
          pr.stock_items.map(&:count_on_hand).sum,
          pr.taxons.select { |t| t.taxonomy.name.eql?(Spree.t(:taxonomy_categories_name)) }.sort_by {|t| t.depth }.first.name
        ]
      end
    end
  end  
end
