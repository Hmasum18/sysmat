package io.github.hmasum18.sysmat.service;

import io.github.hmasum18.sysmat.model.User;
import io.github.hmasum18.sysmat.repository.UserRepository;
import io.github.hmasum18.sysmat.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class MyUserDetailsService implements UserDetailsService {
    public static final String TAG = "MyUserDetailsService->";

    @Autowired
    private PasswordEncoder bCryptPasswordEncoder;

    @Autowired
    UserRepository userRepository;

    @Autowired
    JwtUtil jwtUtil;

    @Override
    public UserDetails loadUserByUsername(String username) throws AuthenticationException {
        //return new SysMatUserDetails(username);
        Optional<User> optionalUser = userRepository.findByUsername(username);

        if(!optionalUser.isPresent()){
            System.out.println(TAG+username+" not found.");
            throw new UsernameNotFoundException(username+" not found.", new Throwable(username+" not found."));
        }
        else{
            if(!optionalUser.get().isVerified()){
                System.out.println(TAG+username+" found. But nof verified.");
                throw new UsernameNotFoundException(username+" not verified.");
            }
            System.out.println(TAG+username+" found");
        }


        User user = optionalUser.get();
        System.out.println(TAG+user);
        UserDetails userDetails = user.buildUserDetails();
        System.out.println(TAG+userDetails);

        return userDetails;
    }

    public boolean validateUserCredential(String username, String password){
        Optional<User> optionalUser = userRepository.findByUsername(username);
        if(optionalUser.isEmpty()){
            return false;
        }

       return bCryptPasswordEncoder.matches(password, optionalUser.get().getPassword());
    }
}
