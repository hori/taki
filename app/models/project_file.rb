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
end
