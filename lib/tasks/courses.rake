desc 'Crawl courses from http://www.prospects.ac.uk/'
task courses: :environment do
  base_url = "http://www.prospects.ac.uk"
  search_extension = "/search_courses_results.htm"
  pagination = "?p="
  start_pagination = 1
  end_pagination = 50
  agent = Mechanize.new
  course_url = Array.new
  (start_pagination..end_pagination).each do |page|
    search_page = base_url + search_extension + pagination + page.to_s
    page = agent.get search_page
    page.search('h3').each do |course_link|
      course_url << base_url + course_link.at('a').attr('href') if course_link.at('a')
    end
  end
  fields = {"Department name" => "department", "Qualification, duration, mode" => "qdmode","Months of entry" => "intake",
    "Entry requirements" => "requirements", "Information for International Students" => "intl",
    "Course description" => "desc", "UK students fees" => "ukfee",
    "International students fees" => "internfee", "Funding" => "fund", "Named pathways" => "named_pathway",
    "New students enrolled annually" => "new_enrollment", "Total enrolled students" => "total_enrollment",
    "Bursaries" => "bursaries", "Scholarships" => "scholarships", "GREAT Scholarships" => "gscholarships",
    "Contact name" => "contact_name",
    "Contact email" => "contact_email", "Contact phone" => "contact_phone", "Contact web" => "contact_web",
    "Apply online" => "apply_link"}

  html_fields = ["Entry requirements", "Information for International Students", "Course description",
                  "Funding", "Named pathways", "GREAT Scholarships", "Scholarships", "Bursaries"]
  link_fields = ["Apply online"]
  course_url.each do |course|
    page = agent.get course
    params = {}
    params["university"] = page.at('h1/span.pseudo_h2').text.squish
    params["name"] = page.at('h1').text.squish.split(params["university"])[0]
    page.search('dl.simpledefinitionlist/dt').each do |course_field|
      if fields.keys.include?(course_field.text.squish)
        if html_fields.include?(course_field.text.squish)
          params[fields[course_field.text.squish]] = course_field.next_element.to_html
        elsif link_fields.include?(course_field.text.squish)
          params[fields[course_field.text.squish]] = course_field.next_element.at('a').attr('href').strip
        else
          params[fields[course_field.text.squish]] = course_field.next_element.text.squish
        end
      end
    end
    p page.uri.to_s
    Course.create(params)
  end
end
