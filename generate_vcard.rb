#!/usr/bin/env ruby

require 'yaml'
require 'base64'

class VCardGenerator
  def initialize
    @config = YAML.load_file('_data/vcard.yml')
  end

  def generate
    vcard = []
    
    # Header
    vcard << "BEGIN:VCARD"
    vcard << "VERSION:#{@config['settings']['version']}"
    
    # Personal Information
    personal = @config['personal']
    vcard << "N:#{personal['last_name']};#{personal['first_name']};;;"
    vcard << "FN:#{personal['full_name']}"
    
    # Title and Organization
    vcard << "TITLE:#{personal['title']}" unless personal['title'].empty?
    vcard << "ORG:#{personal['organization']}" unless personal['organization'].empty?
    
    # Email addresses
    contact = @config['contact']
    if contact['email']['personal'] && !contact['email']['personal'].empty?
      vcard << "EMAIL;type=INTERNET;type=HOME;type=pref:#{contact['email']['personal']}"
    end
    
    if contact['email']['work'] && !contact['email']['work'].empty?
      vcard << "EMAIL;type=INTERNET;type=WORK:#{contact['email']['work']}"
    end
    
    # Phone numbers
    if contact['phone'] && !contact['phone'].empty?
      vcard << "TEL;type=CELL;type=VOICE;type=pref:#{contact['phone']}"
      vcard << "TEL;type=FACETIME:#{contact['phone']}"
    end
    
    # Websites
    item_counter = 1
    if contact['websites']['personal'] && !contact['websites']['personal'].empty?
      vcard << "item#{item_counter}.URL;type=pref:#{contact['websites']['personal']}"
      vcard << "item#{item_counter}.X-ABLabel:Personal Website"
      item_counter += 1
    end
    
    if contact['websites']['work'] && !contact['websites']['work'].empty?
      vcard << "item#{item_counter}.URL:#{contact['websites']['work']}"
      vcard << "item#{item_counter}.X-ABLabel:Work Website"
      item_counter += 1
    end
    
    # Social Media / Messaging
    social = @config['social']
    
    # Telegram
    if social['telegram'] && !social['telegram'].empty?
      vcard << "item#{item_counter}.IMPP;X-SERVICE-TYPE=Telegram:telegram:@#{social['telegram']}"
      vcard << "item#{item_counter}.X-ABLabel:Telegram"
      item_counter += 1
    end
    
    # WhatsApp
    if social['whatsapp'] && !social['whatsapp'].empty?
      vcard << "item#{item_counter}.IMPP;X-SERVICE-TYPE=WhatsApp:whatsapp:+#{social['whatsapp']}"
      vcard << "item#{item_counter}.X-ABLabel:WhatsApp"
      item_counter += 1
    end
    
    # Photo
    photo_config = @config['photo']
    if photo_config['path'] && File.exist?(photo_config['path'])
      photo_data = encode_photo(photo_config['path'])
      vcard << "PHOTO;ENCODING=b;TYPE=#{photo_config['type']}:#{photo_data}"
    else
      puts "Warning: Photo file not found at #{photo_config['path']}"
    end
    
    # Footer
    vcard << "END:VCARD"
    
    vcard.join("\n")
  end
  
  def encode_photo(photo_path)
    begin
      photo_binary = File.read(photo_path)
      Base64.strict_encode64(photo_binary)
    rescue => e
      puts "Error encoding photo: #{e.message}"
      ""
    end
  end
  
  def save_vcard(content, filename = 'andrius-kairiukstis.vcf')
    File.write(filename, content)
    puts "vCard generated successfully: #{filename}"
    puts "File size: #{File.size(filename)} bytes"
  end
end

# Main execution
if __FILE__ == $0
  begin
    generator = VCardGenerator.new
    vcard_content = generator.generate
    generator.save_vcard(vcard_content)
  rescue => e
    puts "Error generating vCard: #{e.message}"
    exit 1
  end
end