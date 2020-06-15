package model;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Product {
	private int id;
	private String title;
	private String overview;
	private String release_date;
	private String poster_path;
	private String genres;
	private String price;
	// extra data
	private String imdb_id;
	Product(String title, String overview, String release_date, 
		String poster_path, String genres, String price, String imdb_id){
		this.title = title;
		this.overview = overview;
		this.release_date = release_date;
		this.poster_path = poster_path;
		this.genres = genres;
		this.price = price;
		this.imdb_id = imdb_id;
	};
}