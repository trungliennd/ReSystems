package SystemsFilterFile;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;


class Pair {
	int movie_id;
	float ratingofMovie;
	
	public Pair(int a,float b) {
		movie_id = a;
		ratingofMovie  = b;
	}
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		StringBuilder strings = new StringBuilder();
		strings.append("(" + movie_id + ", " + ratingofMovie + ")" );
		return strings.toString();
	}
}


public class FilterFileDataRatings {

	public static final String PATH = "F:\\Java\\ReSystems\\data";
	
	private Map<Integer, ArrayList<Pair>> user_movies;
	private Map<Integer,Integer> movieId_index;
	//private double matrix_user_movie[];
	private BufferedReader bufferedReader;
	private BufferedWriter bufferedWriter;
	
	
	public FilterFileDataRatings() {
		// TODO Auto-generated constructor stub
		user_movies = new HashMap<Integer, ArrayList<Pair>>();
		movieId_index = new HashMap<Integer, Integer>();
	}
	
	
	public void countUser(String filename) throws IOException {
		bufferedReader = new BufferedReader(new FileReader(new File(filename)));
		bufferedReader.readLine();
		String line = bufferedReader.readLine();
		int count = 0;
		int user_id = 1;
		while(line != null) {
			String strings[] = line.split("::");
			if(user_id != Integer.parseInt(strings[0])){
				user_id = Integer.parseInt(strings[0]);
//				System.out.println("count is: " + "(" +user_id +", "+ count+")");
				count++;
			}
			line = bufferedReader.readLine();
		}
		count++;
		System.out.println("user is: " + count);
		bufferedReader.close();
	}
	
	public void readFileMoives(String filename) throws IOException{
		bufferedReader = new BufferedReader(new FileReader(new File(filename)));
		String line = bufferedReader.readLine();
		int count = 0;
		while(line != null) {
			String line_one[] = line.split("\t");
			movieId_index.put(Integer.parseInt(line_one[0]), count);
			count++;
			line = bufferedReader.readLine();
		}
		bufferedReader.close();
	}
	
	public void readFileRating(String filename) throws IOException {
		bufferedReader = new BufferedReader(new FileReader(new File(PATH + "\\ml-1m\\" + filename)));
		//bufferedReader.readLine();
		//int count = 0;
		String line = bufferedReader.readLine();
		while(line != null) {
			String line_index[] = line.split("::");
			Integer user_id = Integer.parseInt(line_index[0]);
			Pair movieAndRating = new Pair(Integer.parseInt(line_index[1]),Float.parseFloat(line_index[2]));
			if(user_movies.containsKey(user_id)) {
				user_movies.get(user_id).add(movieAndRating);
			}else {
				ArrayList<Pair> list = new ArrayList<Pair>();
				list.add(movieAndRating);
				user_movies.put(user_id, list);
			}
			line = bufferedReader.readLine();
			System.out.println("Running ...");
		}
		bufferedReader.close();
		System.out.println("READ FILE DONE!");
	}


	public void sortUserId() {
		List<Map.Entry<Integer, ArrayList<Pair>>> list =  new LinkedList<>(user_movies.entrySet());
		Collections.sort(list,new Comparator<Map.Entry<Integer,
				ArrayList<Pair>>>() {
			@Override
			public int compare(Entry<Integer, ArrayList<Pair>> o1,
					Entry<Integer, ArrayList<Pair>> o2) {
				// TODO Auto-generated method stub
				return (o1.getKey()).compareTo(o2.getKey());
			}
		});
		user_movies.clear();
		user_movies = new LinkedHashMap<>();
		for (Map.Entry<Integer, ArrayList<Pair>> entry : list) {
            user_movies.put(entry.getKey(), entry.getValue());
	    }
		System.out.println("SORTED DONE!");
	}
	
	public void writeSparseMatrix(String filename) throws IOException {
		sortUserId();
		bufferedWriter = new BufferedWriter(new FileWriter(new File(filename)));
		Set<Map.Entry<Integer, ArrayList<Pair>>> set = user_movies.entrySet();
		for(Map.Entry<Integer, ArrayList<Pair>> rate:set) {
			ArrayList<Pair> list = rate.getValue();
			int size = list.size();
			int user_id = rate.getKey();
			for(int i = 0;i < size;i++) {
				StringBuffer strings = new StringBuffer();
				int movie_id = movieId_index.get(list.get(i).movie_id);
				strings.append(user_id);
				strings.append("\t");
				strings.append(movie_id + 1);
				strings.append("\t");
				strings.append(list.get(i).ratingofMovie);
				strings.append("\n");
				bufferedWriter.write(strings.toString());
			}
		}
		bufferedWriter.flush();
		bufferedReader.close();
	}
	
	public void readAndWrite(String filename1,String filename2) throws IOException {
		bufferedWriter = new BufferedWriter(new FileWriter(new File(filename2)));
		bufferedReader = new BufferedReader(new FileReader(new File(filename1)));
		String line = bufferedReader.readLine();
		while(line != null) {
			String line_index[] = line.split("\t");
			StringBuffer strings = new StringBuffer();
			strings.append(line_index[0]);
			strings.append("\t");
			strings.append(line_index[1]);
			strings.append("\t");
			strings.append(line_index[2]);
			strings.append("\n");
			bufferedWriter.write(strings.toString());
			line = bufferedReader.readLine();
		}
		bufferedReader.close();
		bufferedWriter.close();
		System.out.println("READ AND WRITE FILE DONE!");
	}
	
	public static void main(String args[]) throws IOException {
		FilterFileDataRatings filter = new FilterFileDataRatings();
		filter.readAndWrite("data\\ml-100k\\u2.test", "data\\XuLyFile\\u2_test.txt");
	}


	public Map<Integer, ArrayList<Pair>> getUser_movies() {
		return user_movies;
	}


	public void setUser_movies(Map<Integer, ArrayList<Pair>> user_movies) {
		this.user_movies = user_movies;
	}


	public Map<Integer, Integer> getMovieId_index() {
		return movieId_index;
	}


	public void setMovieId_index(Map<Integer, Integer> movieId_index) {
		this.movieId_index = movieId_index;
	}


	public BufferedReader getBufferedReader() {
		return bufferedReader;
	}


	public void setBufferedReader(BufferedReader bufferedReader) {
		this.bufferedReader = bufferedReader;
	}


	public BufferedWriter getBufferedWriter() {
		return bufferedWriter;
	}


	public void setBufferedWriter(BufferedWriter bufferedWriter) {
		this.bufferedWriter = bufferedWriter;
	}
	

}
