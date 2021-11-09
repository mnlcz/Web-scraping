# frozen_string_literal: true

require 'httparty'
require 'nokogiri'

class Equipo
  def initialize(nombre, posicion)
    @nombre = nombre
    @posicion = posicion
  end

  def mostrar
    puts "#{@posicion} \t #{@nombre}"
  end
end

def scraper
  url = 'https://www.espn.com.ar/futbol/posiciones/_/liga/arg.1/primera-division-de-argentina'
  pagina = HTTParty.get(url) # get request -> raw html
  pagina_parseada = Nokogiri::HTML(pagina)
  lista_equipos = pagina_parseada.css('div.team-link')
  equipos = []
  lista_equipos.each do |x|
    nombre = x.css('span.dn').text
    posicion = x.css('span.team-position').text
    equipos << Equipo.new(nombre, posicion)
  end
  # binding.pry
  equipos.each(&:mostrar)
end

scraper
