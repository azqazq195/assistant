package example;

public class User {

    private int id = -1;
    private int photoId = -1;
    private String name;
    private String email;
    private int active = -1;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPhotoId() {
        return photoId;
    }

    public void setPhotoId(int photoId) {
        this.photoId = photoId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getActive() {
        return active;
    }

    public boolean active() {
        return active == 1;
    }

    public void setActive(int active) {
        this.active = active;
    }

    public void setActive(boolean active) {
        this.active = active ? 1 : 0;
    }

}