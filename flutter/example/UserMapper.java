package example;

public interface UserMapper {
    public void insertUser(@Param("siteName") String siteName, @Param("value") User value);

    public User getUser(@Param("siteName") String siteName, @Param("option") User option);

    public List<User> listUsers(@Param("siteName") String siteName, @Param("option") User option);

    public void updateUser(@Param("siteName") String siteName, @Param("value") User value);

    public void deleteUser(@Param("siteName") String siteName, @Param("option") User option);
}
