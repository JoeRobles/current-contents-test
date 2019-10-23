require 'httparty'
require 'json'

When("fetching all author list") do
  response = HTTParty.get(
    "https://qjimvba862.execute-api.us-east-2.amazonaws.com/dev/author",
    :headers => { 'Content-Type' => 'application/json' }
  )
  @read_response = JSON.parse(response.body)
end

Then("at least one author should be received") do
  expect(@read_response["Items"].length).to eq(@read_response["Count"])
end

Given(/^a list of authors:$/) do |author|
  @authors = author.hashes
end

When("creating authors") do
  @create_response = []
  @authors.each do |row|
    payload = {
      :authorName => "#{row[:authorName]}",
      :email => "#{row[:email]}",
      :birthDate => "#{row[:birthDate]}"
    }
    response = HTTParty.post(
      "https://qjimvba862.execute-api.us-east-2.amazonaws.com/dev/author",
      :headers => {
        "Content-Type" => "application/json"
      },
      :body => payload.to_json
    )

    @create_response.push(JSON.parse(response.body))
  end
end

Then("the author has to be in the list") do
  @authors.each_with_index do |row, index|
    expect(@create_response[index]["authorId"]).to be
    expect(@create_response[index]["authorName"]).to eq(row[:authorName])
    expect(@create_response[index]["email"]).to eq(row[:email])
    expect(@create_response[index]["birthDate"]).to eq(row[:birthDate])
    expect(@create_response[index]["createdAt"]).to be
  end
end

When("updating author attributes") do
  @update_response = []
  @create_response.each_with_index do |row, index|
    payload = {
      :Item => {
        :authorName => "#{index}-customAuthorName",
        :birthDate => "#{index}-customBirthDate",
        :email => "#{index}-customEmail"
      }
    }

    response = HTTParty.put(
      "https://qjimvba862.execute-api.us-east-2.amazonaws.com/dev/author/#{row["authorId"]}",
      :headers => {
        "Content-Type" => "application/json"
      },
      :body => payload.to_json
    )

    @update_response.push(JSON.parse(response.body))
  end
end

Then("should retrieve updated author attributes") do
  @authors.each_with_index do |row, index|
    expect(@update_response[index]["authorId"]).to eq(row[:authorId])
    expect(@update_response[index]["authorName"]).to eq("#{index}-customAuthorName")
    expect(@update_response[index]["email"]).to eq("#{index}-customEmail")
    expect(@update_response[index]["birthDate"]).to eq("#{index}-customBirthDate")
    expect(@update_response[index]["createdAt"]).to eq(row[:createdAt])
  end
end
