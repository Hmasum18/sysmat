package io.github.hmasum18.sysmat.service;

import io.github.hmasum18.sysmat.model.User;
import io.github.hmasum18.sysmat.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class SysMatUserDetailsService implements UserDetailsService {
    @Autowired
    UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        //return new SysMatUserDetails(username);
        Optional<User> optionalUser = userRepository.findByUsername(username);
        optionalUser.orElseThrow(()-> new UsernameNotFoundException(username+" not found."));

        User user = optionalUser.get();

        Set<GrantedAuthority> grantedAuthorities = Arrays.stream(user.getRoles().split(","))
                                                        .map(SimpleGrantedAuthority::new)
                                                        .collect(Collectors.toSet());

        org.springframework.security.core.userdetails.User.UserBuilder userBuilder = org.springframework.security.core.userdetails.User.builder();
        userBuilder.username(user.getUsername())
                .password(user.getPassword())
                .disabled(false)
                .authorities(grantedAuthorities);

        return userBuilder.build();
    }
}
