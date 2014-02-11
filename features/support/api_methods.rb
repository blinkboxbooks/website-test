module APIMethods
  require "httpclient/include_client"
  def create_user_without_client
    @email_address = generate_random_email_address
    @password = "test1234"
    uri = "https://auth.mobcastdev.com//oauth2/token"
    params = {
        grant_type: "urn:blinkbox:oauth:grant-type:registration",
        first_name: generate_random_first_name,
        last_name: generate_random_last_name,
        username: @email_address,
        password: @password,
        accepted_terms_and_conditions: true,
        allow_marketing_communications: false
    }
    headers = { "Content-Type" => "application/x-www-form-urlencoded", "Accept" => "application/json" }
    response = http_client.post(uri, body: params, header: headers)
    raise "Test Error: Failed to register new user" unless response.status == 200
    user_props = MultiJson.load(response.body)
    @access_token = user_props["access_token"]
  end

  def add_credit_card
    uri = "https://qa.mobcastdev.com/service/my/creditcards"
    params = {
        default:true,
        number:"$bt4|javascript_1_3_6$T0sAOQTAbp17QIqyTh1DUX57xSnXZtoxYqyHiPq8olfaRs4lVxuYZ26CpU2LLGhZelIhWjomHA1ijMPo6It54sqr7XklIaRFZm7WaAgu0KbOrpCpnIxW7oV8d2kqI8cD9BryXlGcapoNb4eQqr52XX+0h041Q0qXvZmKutSlfobD9jOx7z8ljHB6eMEiOj767yun/VI6QDE5v2urAtYfmmxm3Y3pYiPKaw9p2lfkXk5ukgINqU1RYEP2fl+7xXxyEYEu/CuJi29Qvz7HT7tnIygM8yDhmylBp96bZQaC8WZ/KgRCPAtDfIGB+QC1mcb5NfaaBv6ay5jithW6dFn8Eg==$nh4XZjZ+9jLELu3dqQJ+MLxRGfsJXsDR6sUBsth00+DFFa8k+DU3sa/mA5DU2171$7l1vE44chSTexQiFgznXbROyHEFX7D9toVBtOJSKbjg=",
        cvv:"$bt4|javascript_1_3_6$nYUvEVg9T9BOXNl8N530lmFi/XRDdNt/ZI5XJlGHIskXjtMbhPLIJZosJ2h9OFvTCJgSpYPZv7WDlnksbXf46Xq5WfzIaf2jb2Yib7jQsvXDZwMTPvj2vm04+mqXvNCCEniEG7+HwRcyuttx3mtNFX0bnxWNlA31ys6JVP17eHFW+p+7X8WtKyJ3kU44rnMlcPAYTrhtTzUHrOrTAacAh+7119dhRbWbY9OwAWaa/Nx28n5jN12aooUSDmAbyCaMMwfctxOCG73JunrHYoy4MG6EqG6HYdygjgRUAWajmyCgicQVCs486fT1rT3ogur/+H4Yk9rORpBf7pzHRRbuvQ==$xpFlUEZa4EXN94bOo8WuO4WYwNgA4XtFC2iWR7/rQ9I=$6EhQBh7JO/LiX7/z1oyKInjXqk97h0TrjcOs4BL4HDk=",
        expirationMonth:"$bt4|javascript_1_3_6$mMJ5j7iGauw6NypgajVnP4dHqTp3Ks2QOMILSXs3JDg4bVErtbhXSNuVkijQYjwOWwTP+il05DnFnpDUQrORTiIn6Cq1WZFaCEGV0tiTrnIobKpdEBdFKt8EIX5xfZp+2N/m2NXD84J7Qdtu1ZnJCWfSJn+Q/uHlpVecHJLhgjaqLfKEraL9fU0jFSeGcOMh71m6U+cjhSFvyRioa2vCDGoxwsbg0T0zHSiLRMFiNalxUkFzO68yLICMLXjTKLCNi5k3fC0pYNdpp25b985RA128SgT6Je9wlzoVVBgLaiDRzGalaBhAaaN0O2M07d2nDW53nFEvxpix+fZHlYuRXA==$DQIwODOt0hdCResxU5rshK5uOWk0JfxCcMRK48fUT5g=$4htUux4JrAyU/khniSVVyyEWKvplp/+FfFN+0EGyS0Y=",
        expirationYear:"$bt4|javascript_1_3_6$2dTTbUxi7+RIJZa82FyAh1AtofNvLmTPdIwkEWvzrrPVQCMnhsGBvBPPRwzxPXGg+1XBPBuEMyGPPXbbS5Fzrx71X5cywFjEKESMDcpRs1q+yuLGj/l+pB9sJ4rduFu0xy+FWUAATT+53Bp3vuPdXGOyiJ4eJ4I9f4VTGPvPMnzjbMqkI3QuD5CalicUoI8fFAmGaXQhK5YTYADyRBP0eZC6ZPUxxvxvalz6qobLFqQdOpBNgDCkgt3zhM/xF9pWBP9E+rKc8T1pjyPQIPS99dR0iBXCbqENFmvmPC8Cazs7W/se9+gXSxrC+RGNxw/gtxL/38RN2MJmQykMvykBwg==$SdA+Ka5mwe3VWPCwWph7fuUcMvMPnJ7FbmIGGonZqPc=$To3UrC5/HVY98GSmoFxvnlQFzM7XZ5LsoWXO0aC/8js=",
        cardholderName:"jamie jones",
        billingAddress:{line1:"123 my street",line2:"",locality:"mytown",postcode:"wc1x8aq"}
    }
    headers = { "Content-Type" => "application/vnd.blinkboxbooks.data.v1+json", "Authorization" => "Bearer #{@access_token}" }
    body = {"type" => "urn:blinkboxbooks:schema:creditcard"}.merge(params)
    response = http_client.post(uri,body: format_body(body), header: headers)
    raise "Adding credit card failed" unless response.status == 201

  end

  def buy_a_book

  end

  def add_a_device

  end

  def http_client
    @http = HTTPClient.new
  end

  def format_body(body)
    if body.is_a?(Hash)
      MultiJson.dump(body)
    else
      body
    end
  end

end
World(APIMethods)