package desserthouse.dao;

import java.util.List;

import desserthouse.model.User;

public interface UserDao {
	public List<User> Find(String id);
	public List<User> Find();
	public boolean Add(User user);
	public boolean Update(User user);
}
