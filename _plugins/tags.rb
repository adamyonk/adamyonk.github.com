require 'pry'

module Jekyll
  class TagPage < Page
    def initialize(site, tag)
      @site = site
      @base = site.source
      @dir = "tag/#{tag}"
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(site.source, '_layouts'), 'tag.html')
      self.data['tag'] = tag
      self.data['posts'] = site.tags[tag]
      self.data['title'] = "Tag: #{tag}"
    end
  end

  class TagPageGenerator < Generator
    safe true

    def generate(site)
      site.tags.each { |tag|
        write_tag_index(site, tag[0])
      }
    end

    def write_tag_index(site, tag)
      page = TagPage.new(site, tag)
      page.render(site.layouts, site.site_payload)
      page.write(site.dest)
      site.pages << page
    end
  end
end
