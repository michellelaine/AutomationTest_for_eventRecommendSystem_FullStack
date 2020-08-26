# Automation Test for project Event Recommend System FullStack
# by Michelle Ye

Feature: Automation Test

  Background:

    * callonce read('classpath:karate-config.js')


  Scenario: Test Case 1: Automation Test for SearchItem based on location lat=37.38&lon=-122.08

    # /search?lat=37.38&lon=-122.08
    * print "Get Events(items) from TicketMaster with requested location lat=37.38&lon=-122.08(Mountain View)."
    Given url localURL
    Given path "search"
    Given param deep = "true"
    Given param lat = "37.38"
    And param lon = "-122.08"
    When method get
    Then status 200

    * def resLength = response.length
    * assert resLength > 0

    * match each response contains { address: "#? _ != null " }
    * match each response contains { distance: "#? _ != null " }
    * match each response contains { item_id: "#? _ != null " }
    * match each response contains { image_url: "#? _ != null " }
    * match each response contains { name: "#? _ != null " }
    * match each response contains { rating: "#? _ != null " }
    * match each response contains { categories: "#? _ != null " }
    * match each response contains { url: "#? _ != null " }


  Scenario: Test Case 2: Automation Test for setFavourite events(items).
    # /history
    * print "Set favorite event for userid = 1111"
    * def requestBody = {"user_id":"1111","favorite" : ["G5vYZ4gUmWNcz","G5vYZ4gX2VwDx","G5vYZ4M1Nc7-M", "G5vYZ4VqSWoX_"]}
    Given url localURL
    Given path "history"
    And request requestBody
    When method post
    Then status 200

    * match response.result == "SET FAV SUCCESS"


    # /history?user_id=1111
    * print "Get favourite events(items) has marked"
    Given url localURL
    Given path "history"
    And param user_id = "1111"
    When method get
    Then status 200

    * def isFavourite = function(x) { return x == 'G5vYZ4gUmWNcz' || x == 'G5vYZ4gX2VwDx' || x == 'G5vYZ4M1Nc7-M' || x == 'G5vYZ4VqSWoX_'}
    * match each response contains { item_id: '#? isFavourite(_)' }


  Scenario: Test Case 3: Automation test for unSet favourite events.
    # /history
    * print "Delete favorite events for userid = 1111"
    * def requestBody = {"user_id":"1111","item_ids" : ["G5vYZ4VqSWoX_", "G5vYZ4gX2VwDx"]}
    Given url localURL
    Given path "history"
    And request requestBody
    When method delete
    Then status 200

    * match response.result == "DELETE SUCCESS"


  # /history?user_id=1111
    * print "Test the items are deleted successfully"
    Given url localURL
    Given path "history"
    And param user_id = "1111"
    When method get
    Then status 200

    * def isFavourite = function(x) { return x == 'G5vYZ4gUmWNcz' || x == 'G5vYZ4M1Nc7-M'}
    * match each response contains { item_id: '#? isFavourite(_)' }


  Scenario: Test Case 4: Automation Test for Recommendation events.
    # /recommendation?user_id=1111&lat=37.38&lon=-122.08
    * print "Recommend the user with the events types he used to like and close to lat=37.38&lon=-122.08"
    Given url localURL
    Given path "recommendation"
    Given param user_id = 1111
    And param lat = "37.38"
    And param lon = -122.08
    When method get
    Then status 200

    * def resLength = response.length
    * print resLength
    #* assert resLength > 0

    * match each response contains { address: "#? _ != null " }
    * match each response contains { distance: "#? _ != null " }
    * match each response contains { item_id: "#? _ != null " }
    * match each response contains { image_url: "#? _ != null " }
    * match each response contains { name: "#? _ != null " }
    * match each response contains { rating: "#? _ != null " }
    * match each response contains { categories: "#? _ != null " }
    * match each response contains { url: "#? _ != null " }

















