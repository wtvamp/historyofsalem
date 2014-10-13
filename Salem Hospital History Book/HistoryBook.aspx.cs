using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Salem_Hospital_History_Book
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (Page.IsPostBack == true)
            {
                return;
            }

            int[] timeLinePos = new int[31] { 125, 170, 309, 360, 406, 441, 476, 511, 556, 651, 786, 851, 906, 961, 996, 1051, 1126, 1161, 1206, 1241, 1276, 1311, 1376, 1451, 1556, 1591, 1626, 1661, 1696, 1731, 1750 };
            string[] timeLineYear = new string[31] {
                "1896",
                "1899",
                "1916",
                "1918",
                "1924",
                "1925",
                "1926",
                "1927",
                "1929",
                "1931",
                "1940",
                "1951",
                "1953",
                "1953",
                "1955",
                "1958",
                "1962",
                "1962",
                "1964",
                "1964",
                "1966",
                "1967",
                "1968",
                "1969",
                "1970's",
                "1980's",
                "1996",
                "2000",
                "2003",
                "2005",
                "2011"
            };
            string[] timeLineDesc = new string[31] {
                "Salem Hospital established",
                "Hospital moves to Glen Oaks Orphan's Home",
                "Salem Deaconess Hospital established",
                "Former Capital Hotel becomes Salem Deaconess Hospital",
                "Salem Hospital installs it's first X-ray machine",
                "Salem Hopsital hires it's first lab technician",
                "Salem Hospital expands it's Center Street location",
                "Salem Hospital renames itself Salem General Hospital",
                "Auxiliary established as fundraising group",
                "Frank Wedel manages Salem Deaconesss, as Great Depression looms",
                "Staffing becomes a concern during World War II",
                "Salem Hospital's first pharmacist is hired",
                "Patient amentities are introducted into both hospitals",
                "Salem General expands by constructing it's Morse building",
                "The first televisions are installed in patient rooms",
                "Salem Hospital adds five new surgical rooms",
                "The Columbus Day Storm",
                "The Columbus Day Storm",
                "Salem Memorial's basement is flooded",
                "Salem Memorial is evacuated",
                "Computers are introducted to business operations at both Salem General and Salem Memorial",
                "Salem General and Salem Memorial continue to expand",
                "Salem General and Salem Memorial begin merger discussions",
                "Salem General merges with Salem Memorial, renamed as Salem Hospital",
                "Salem Hospital adds North and South Towers as it continues to expand",
                "Salem Hospital provides advances in mental health care",
                "Salem Hospital experiences a second major flood",
                "Salem Hospital purchases West Valley Hospital in Dallas",
                "Salem Hospital's Family Birth Center Opens",
                "Salem Hospital's OB Hospitalist program established",
                "Salem Hospital - Today"
            };
            

            

            for (int drawTimelinePoints = 0; drawTimelinePoints <= 30; drawTimelinePoints++)
            {
                // Create the green dot on the timeline, and the blue box next to it.
                // The blue box next to it is hidden via css by default.
                HtmlGenericControl timeLinePointDiv = new HtmlGenericControl("div");
                timeLinePointDiv.Attributes["class"] = "timeline-event";
                timeLinePointDiv.Style["left"] = timeLinePos[drawTimelinePoints] + "px";
                HtmlGenericControl timelineEventTooltip = new HtmlGenericControl("div");
                timelineEventTooltip.Attributes["class"] = "timeline-event-tooltip";
                
                // Create the timeline date and short description.
                HtmlGenericControl dateDiv = new HtmlGenericControl("div");
                dateDiv.InnerText = timeLineYear[drawTimelinePoints];
                HtmlGenericControl shortDesc = new HtmlGenericControl("div");
                shortDesc.InnerText = timeLineDesc[drawTimelinePoints];
                
                // Add the date and short description to the blue box.  Add the hidden
                // blue box next to the green dot.  Add the green dot to the timeline.
                timelineEventTooltip.Controls.Add(dateDiv);
                timelineEventTooltip.Controls.Add(shortDesc);
                timeLinePointDiv.Controls.Add(timelineEventTooltip);
                timelineScroll.Controls.Add(timeLinePointDiv);
            }

            // Create the timeline cursor
            Image timelineCursor = new Image();
            timelineCursor.ImageUrl = "Images/icon.png";
            timelineCursor.ID = "timelineCursor";
            timelineCursor.AlternateText = "The timeline to move the cursor";
            timelineCursor.Style["left"] = "-1230px";

            // Add the cursor after all the events are drawn, above.
            timelineScroll.Controls.Add(timelineCursor);
            
        }
    }
}