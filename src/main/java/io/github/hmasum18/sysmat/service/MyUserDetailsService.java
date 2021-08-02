package io.github.hmasum18.sysmat.service;

import io.github.hmasum18.sysmat.model.User;
import io.github.hmasum18.sysmat.repository.UserRepository;
import io.github.hmasum18.sysmat.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class MyUserDetailsService implements UserDetailsService {
    public static final String TAG = "MyUserDetailsService->";

    @Autowired
    UserRepository userRepository;

    @Autowired
    JwtUtil jwtUtil;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        //return new SysMatUserDetails(username);
        Optional<User> optionalUser = userRepository.findByUsername(username);

        if(!optionalUser.isPresent())
            System.out.println(TAG+username+" not found.");
        else
            System.out.println(TAG+username+" found");

        optionalUser.orElseThrow(()-> new UsernameNotFoundException(username+" not found."));

        User user = optionalUser.get();
        System.out.println(TAG+user);
        System.out.println(TAG+user.buildUserDetails());

        return user.buildUserDetails();
    }
}
