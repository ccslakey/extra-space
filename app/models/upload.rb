class Upload < ApplicationRecord
  has_attached_file :file
  serialize :file, Array
  validates_attachment :file, presence: true,
                              content_type: { content_type: ["image/jpeg", "image/gif", "image/png", "application/pdf", "video/mp4", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"] },
                              size: { in: 0..1000000.megabytes }



  def is_pdf?
    file_content_type == "application/pdf"
  end

  def is_doc?
    file_content_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    # could add some more file types here
  end
  def is_vid?
    file_content_type == "video/mp4"
  end

  def is_image?
     ["image/jpeg", "image/gif", "image/png"].include? file_content_type
  end

  def unhandled_type?
    ["image/jpeg", "image/gif", "image/png", "video/mp4" ].include? file_content_type
  end

  def self.search(search)
    if search
      # search in original file name, title, desc, or content_type
      where('LOWER(file_file_name) LIKE :search OR LOWER(description) LIKE :search OR LOWER(title) LIKE :search OR LOWER(file_content_type) LIKE :search', search: "%#{search.downcase}%")
    else
      all
    end
  end

end
