public class HotelWrapper
{
        public String term;	//Jaipur
        public Integer moresuggestions;	//10
        public cls_autoSuggestInstance autoSuggestInstance;
        public String trackingID;	//b35bff128aff48fa93b755a79491656b
        public boolean misspellingfallback;
        public cls_suggestions[] suggestions;
        public boolean geocodeFallback;
       public class cls_autoSuggestInstance 
        {
        }
        public class cls_suggestions
        {
            public String group1;	//CITY_GROUP
            public cls_entities[] entities;
        }
        public class cls_entities 
        {
            public String geoId;	//1669
            public String destinationId;	//687244
            public String landmarkCityDestinationId;
            public String type;	//CITY
            public String redirectPage;	//DEFAULT_PAGE
            public Double latitude;	//26.912428
            public Double longitude;	//75.78727
            public cls_searchDetail searchDetail;
            public String caption;	//<span class='highlighted'>Jaipur</span>, Rajasthan, India
            public String name;	//Jaipur
        }
        public class cls_landmarkCityDestinationId 
        {
        }
        public class cls_searchDetail
        {
        }
        public static HotelWrapper parse(String json)
        {
            return (HotelWrapper) System.JSON.deserialize(json, HotelWrapper.class);
        }

    
}