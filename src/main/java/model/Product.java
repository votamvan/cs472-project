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
}