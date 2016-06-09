
/**
 * Copyright 2013 Micro Focus. All rights reserved. Portions Copyright 1992-2009 Borland Software Corporation (a Micro
 * Focus company).
 */

import org.junit.Assert;

import com.borland.silk.keyworddriven.annotations.Keyword;
import com.borland.silktest.jtf.Desktop;
import com.borland.silktest.jtf.MobileBaseState;
import com.microfocus.silktest.jtf.mobile.MobileDevice;
import com.microfocus.silktest.jtf.mobile.MobileObject;
import com.microfocus.silktest.jtf.mobile.MobileTextField;
import com.microfocus.silktest.jtf.mobile.common.types.DisplayOrientation;

public class Keywords {

  private Desktop desktop = new Desktop();

  @Keyword(value = "Start application", isBaseState = true)
  public void start_application() {
    MobileBaseState baseState = new MobileBaseState();
    baseState.execute(desktop);
  }

  @Keyword("Login")
  public void login(String email, String password) {
    desktop.<MobileObject> find("Device.Email").typeKeys(email);
    desktop.<MobileObject> find("Device.Password").typeKeys(password);
    desktop.<MobileObject> find("Device.Login").click();
  }

  @Keyword("Agent Lookup")
  public void agentLookup() {
    desktop.<MobileObject> find("Device.menu").click();
    desktop.<MobileObject> find("Device.Agent Lookup").click();
    desktop.<MobileObject> find("Device.Zip Code").typeKeys("78731");
    desktop.<MobileObject> find("Device.Search").click();
    MobileObject _1AgentFound = desktop.<MobileObject> find("Device.1 agent found");
    Assert.assertEquals("1 agent found", _1AgentFound.getText());
    desktop.<MobileObject> find("Device.Back").click();
  }

  @Keyword("About")
  public void about() {
    desktop.<MobileObject> find("Device.menu").click();
    desktop.<MobileObject> find("Device.About").click();
  }

  @Keyword("Logout")
  public void logout() {
    desktop.<MobileObject> find("Device.menu").click();
    desktop.<MobileObject> find("Device.Logout").click();
  }

  @Keyword("Rotate Device")
  public void rotate_Device(DisplayOrientation orientation) {
    desktop.<MobileDevice> find("Device").rotate(orientation);
  }

  @Keyword("Go to Agent Lookup")
  public void go_to_Agent_Lookup() {
    desktop.<MobileObject> find("Device.menu").click();
    desktop.<MobileObject> find("Device.Agent Lookup").click();
  }

  @Keyword("Lookup Agents by Name")
  public void lookup_Agents_by_Name(String Param1) {
    desktop.<MobileTextField> find("Device.Name").setText("*");
    desktop.<MobileObject> find("Device.Search by agent name").click();
    desktop.<MobileObject> find("Device.Search4").click();
    MobileObject _6AgentsFound = desktop.<MobileObject> find("Device.6 agents found");
    Assert.assertEquals("6 agents found", _6AgentsFound.getText());
  }

  @Keyword("Go back")
  public void go_back() {
    desktop.<MobileObject> find("Device.Back").click();
  }

  @Keyword("Go to AutoQuote")
  public void go_to_AutoQuote() {
    desktop.<MobileObject> find("Device.menu").click();
    desktop.<MobileObject> find("Device.Auto Quote").click();
  }

  @Keyword("Set zip code")
  public void set_zip_code() {
    desktop.<MobileTextField> find("Device.Zip Code TextField").setText("78731");
  }

  @Keyword("Set email")
  public void set_email() {
    desktop.<MobileTextField> find("Device.john smith gmail com").setText("john.smith@gmail.com");
  }

  @Keyword("Set age")
  public void set_age() {
    desktop.<MobileTextField> find("Device.36").setText("36");
    desktop.<MobileObject> find("Device.Personal Data").click();
  }

  @Keyword("Set personal data")
  public void set_pesonal_data() {
    desktop.<MobileObject> find("Device.Male").click();
    desktop.<MobileObject> find("Device.Good").click();
  }

  @Keyword("Set car data")
  public void set_car_data() {
    desktop.<MobileDevice> find("Device").swipeUp();
    desktop.<MobileObject> find("Device.Car").click();
    desktop.<MobileTextField> find("Device.Year").setText("2000");
    desktop.<MobileObject> find("Device.Automobile Information").click();
    desktop.<MobileObject> find("Device.Select").click();
    desktop.<MobileObject> find("Device.Toyota").click();
    desktop.<MobileObject> find("Device.Select").click();
    desktop.<MobileObject> find("Device.Hilux").click();
    desktop.<MobileObject> find("Device.Own").click();
    desktop.<MobileObject> find("Device.Submit").click();
  }

  @Keyword("Validate quote")
  public void validate_quote() {
    MobileObject yourInstantQuoteIs13000EveryTwelveMonths = desktop
        .<MobileObject> find("Device.Your Instant Quote is 1300 0 every twelve months");
    Assert.assertEquals("Your Instant Quote is 1300.0 every twelve months.",
        yourInstantQuoteIs13000EveryTwelveMonths.getText());
  }

}