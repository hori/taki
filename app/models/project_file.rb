class ProjectFile < ActiveRecord::Base
  attr_accessible :attachment, :status
  has_many :project_file_media_queries
  has_many :project_file_selectors

  after_commit :css_parser, :on => [:create, :update]

  has_attached_file :attachment

  validates_attachment :attachment, presence: true,
    content_type: { content_type: ["text/css"] },
    size: { less_than: 10.megabytes }

  def attachment_contents
    attachment.copy_to_local_file.read
  end

  def css_parser
    parse = CssParser::Parser.new
    parse.class_eval { attr_reader :rules }

    parse.load_uri!(self.attachment.path)
    parse.rules.each do |rule|
      project_file_selector = self.project_file_selectors.create({
        :name => rule[:rules].selectors.join(', '),
        :raw => rule[:rules].to_s,
      })

      project_file_media_query = self.project_file_media_queries.create({
        :name => rule[:media_types].join(' '),
        :project_file_selector_id => project_file_selector.id,
      }) unless rule[:media_types].blank?

      rule[:rules].class_eval { attr_reader :declarations }
      rule[:rules].declarations.keys.each_with_index do |name, i|
        project_file_selector.project_file_selector_properties.create({
          :name => name,
          :value => rule[:rules].declarations.values[i][:value],
          :is_important => rule[:rules].declarations.values[i][:is_important]
        })
      end
    end
  end

  def calc_similarities()

    similarities = []
    combinations = []

    selector_ids = self.project_file_selectors.where(project_file_id: self.id).pluck(:id)

    selector_ids.each_with_index do |id_a, index|
      for id_b in selector_ids[index+1..-1] do
        combinations << %W|#{id_a} #{id_b}|
      end
    end

    # @todo parallelization
    for selector_ids in combinations do
      match_prop = 0
      match_val = 0
      properties_a = ProjectFileSelectorProperty.where(project_file_selector_id: selector_ids[0]).map(&:serializable_hash)
      properties_b = ProjectFileSelectorProperty.where(project_file_selector_id: selector_ids[1]).map(&:serializable_hash)

      properties_a.each_with_index do |property_a, index_a|
        properties_b.each_with_index do |property_b, index_b|
          if property_a['name'] == property_b['name'] then
            match_prop+=1
            if property_a['value'] == property_b['value'] then
              match_val+=1
            end
          end
        end
      end

      unique_property_count = properties_a.count + properties_b.count - match_prop

      similarities << ProjectFileSelectorSimilarity.create(
        :current_selector_id => selector_ids[0],
        :compared_selector_id => selector_ids[1],
        :property => (match_prop.to_f / unique_property_count.to_f),
        :value => (match_prop.to_f / unique_property_count.to_f),
      )

    end
    similarities
  end

end
