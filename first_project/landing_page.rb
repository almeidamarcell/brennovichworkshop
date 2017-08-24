class LandingPage
def call(env)
  puts env
case env['PATH_INFO']
when '/'
  params = parse_query_string(env['QUERY_STRING'])

  image = case params['name']
  when 'Ronaldo'
    'http://images.performgroup.com/di/library/GOAL/15/c8/ronaldo-nazario-real-madrid_uowrhe3shq301vp41b5ha5ct4.jpg?t=2030042668&w=620&h=430'
  else
    'https://media.giphy.com/media/3oKIP91E6b1mNpP9oQ/giphy.gif'
  end

  [200, {'Content-Type' => 'text/html'}, [File.read('index.html')
        .gsub('#IMAGE', image)
    ]
  ]
when '/style.css'
  [200, {'Content-Type' => 'text/css'}, [File.read('style.css')]]
else
  [404, {}, []]
  end
rescue => e
  puts e
  [500, {}, ['Server Errpr']]

end

def parse_query_string(string)
params = {}
  string.split('&').each do |param|
    key, value = param.split('=')
  params[key] = value
  end
  params
end

end
