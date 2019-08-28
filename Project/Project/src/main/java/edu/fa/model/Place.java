package edu.fa.model;

public class Place {
	private int place_ID;
	private String placeName;

	public int getPlace_ID() {
		return place_ID;
	}

	public void setPlace_ID(int place_ID) {
		this.place_ID = place_ID;
	}

	public String getPlaceName() {
		return placeName;
	}

	public void setPlaceName(String placeNamem) {
		placeName = placeNamem;
	}

	public Place() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Place(String placeNamem) {
		super();
		placeName = placeNamem;
	}

	public Place(int place_ID, String placeNamem) {
		super();
		this.place_ID = place_ID;
		placeName = placeNamem;
	}

}
