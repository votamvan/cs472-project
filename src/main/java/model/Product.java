package model;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Product {
	private int id;
	@NotNull
    @Size(min=5, max=255)
	private String title;
	private String overview;
	private String release_date;
	private String poster_path;
	private String genres;
	private String price;
	private String imdb_id;	// extra data
	// method from here
	public Product(String title, String overview, String release_date, 
		String poster_path, String genres, String price, String imdb_id){
		this.title = title;
		this.overview = overview;
		this.release_date = release_date;
		this.poster_path = poster_path;
		this.genres = genres;
		this.price = price;
		this.imdb_id = imdb_id;
	};
	public Product(Integer id, String title, String overview, String release_date, 
		String poster_path, String genres, String price, String imdb_id){
		this(title, overview, release_date, poster_path, genres, price, imdb_id);
		this.id = id;
	};
	public void reset(){
        this.id = -1;
        this.title = null;
        this.overview = null;
        this.release_date = null;
		this.poster_path = null;
		this.genres = null;
		this.price = null;
		this.imdb_id = null;
    }
}