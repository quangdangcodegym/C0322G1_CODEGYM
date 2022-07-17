package com.phuxuan.model;

public class User {
	protected int id;
    protected String name;
    protected String email;
    protected int idcountry;

    public User() {}

    public User(String name, String email, int idcountry) {
        super();
        this.name = name;
        this.email = email;
        this.idcountry = idcountry;
    }

    public User(int id, String name, String email, int idcountry) {
        super();
        this.id = id;
        this.name = name;
        this.email = email;
        this.idcountry = idcountry;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
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

	public int getIdcountry() {
		return idcountry;
	}

	public void setIdcountry(int idcountry) {
		this.idcountry = idcountry;
	}
    

}
